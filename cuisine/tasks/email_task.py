import pymysql.cursors
import requests

BASE_URL = 'http://localhost:3000'

def url_join(*args):
	return '/'.join(list(args))

def prettify(dishes):
	ret = "Today's favorite dishes\n" + '\n'.join(dishes)
	return ret

def makePost(user_email, dishes):
	params = {
	    'subject' : "Today's favorite dishes!",
	    'to':user_email,
	    'text': prettify(dishes)
	}
	response = requests.post(url_join(BASE_URL, 'mail'), 
		data = params)

	return response



# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             db='test',
                             cursorclass=pymysql.cursors.DictCursor)

try:
    with connection.cursor() as cursor:
        # Create a new record
        sql = "SELECT DishId FROM FavoriteDishes GROUP BY DishId ORDER BY count(DishId) desc limit 2"
        cursor.execute(sql)
        result = cursor.fetchall()
        # print result
        q = "SELECT email FROM Users"
        cursor.execute(q)
        email_list = [e['email'] for e in cursor.fetchall()]
        print email_list
        dishes = []
        for dishid in result:
        	q = "SELECT dish_name FROM Dishes WHERE id = %s"
        	# print q
        	cursor.execute(q,(dishid['DishId'],))
        	result = cursor.fetchone()
        	dishes.append(result['dish_name'])
        print dishes
        for email in email_list:
        	makePost(email, dishes)
	 
finally:
    connection.close()