Given a Gemfile, the app checks for License-like files and uses fuzzy
string matching to infer each gem's license.

Built with Sinatra, ActiveRecord, DelayedJob, Bootstrap, fuzzy_match, and Gemnasium's Gemfile parser for [SEP][www.sep.com/labs] Startup Weekend - Spring 2013 edition.

![Home page][http://i.imgur.com/HOWKoPH.png]
![Results][http://i.imgur.com/EqHftgT.png]

## License
MIT

## Improvements
* More robust checking
* Ability to re-check gems
* Handle multiple revisions
* Tie into optional `license` field in .gemspec
* Tie into the new `bundle license` command