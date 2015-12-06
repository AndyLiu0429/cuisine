/**
 * Created by liutianyuan on 11/29/15.
 */
var natural = require("natural");
var tokenizer = new natural.WordTokenizer();

console.log(tokenizer.tokenize("your dog is daa"));

var