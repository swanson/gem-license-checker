Given a Gemfile, the app checks for License-like files and uses fuzzy
string matching to infer each gem's license.

Built with Sinatra, ActiveRecord, DelayedJob, Bootstrap, fuzzy_match, and Gemnasium's Gemfile parser for [SEP Startup Weekend - Spring 2013](www.sep.com/labs).

![Home page](http://i.imgur.com/HOWKoPH.png)
![Results](http://i.imgur.com/EqHftgT.png)

## License
MIT

## Improvements
* More robust checking
* Ability to re-check gems
* Handle multiple revisions
* Tie into optional `license` field in .gemspec
* Tie into the new `bundle license` command

## See also
* Forthcoming [`bundle license`](https://github.com/carlhuda/bundler/pull/1898)
* Pivotal's [LicenseFinder](https://github.com/pivotal/LicenseFinder)
