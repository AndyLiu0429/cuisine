/**
 * Created by liutianyuan on 11/29/15.
 * all the nlp helper functions go here.
 */

var pos = require('pos');
var tagger = new pos.Tagger();
var NNS = ['NNP', 'NNPS', 'NNS', 'NN'];

// get an array of english stopwords
var STOPWORDS = require('stopwords').english;
STOPWORDS.push('I');
var PUNC = /[.,-\/#!$%\^&\*;:{}=\-_`~()]/g;

//console.log(tokenizer.tokenize("your dog is daa"));

var removePunc = function (sentence) {
    if (!sentence) {
        return "";
    }

    return sentence.replace(PUNC, "");
};

var splitSentence = function(sentence) {
    if (!sentence) {
        return [];
    }

    var raw = sentence.split(/[\s,]/);

    return raw;
};

var removeStopWords = function(words) {

    return words.filter(function(word) {
        return STOPWORDS.indexOf(word) == -1;
    });
};

var getNouns = function(words) {
    if (!words) {
        return [];
    }

    var taggedWords = tagger.tag(words);

    var res = [];
    for (var i in taggedWords) {
        var taggedWord = taggedWords[i];
        var word = taggedWord[0];
        var tag = taggedWord[1];
        //console.log(word + " " + tag);
        if (NNS.indexOf(tag) > -1) {
            res.push(word);
        }
    }

    return res;
};


exports.cleanWords = function(sentences) {
    if (!sentences) {
        return "";
    }
    var words = splitSentence(removePunc(sentences));
    var nouns = getNouns(words);

    return removeStopWords(nouns).join(' ');
};

console.log(cleanWords("I hate beef!"));