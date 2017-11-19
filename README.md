## Introduction
This is a simple logs parser. It parses a specifically formatted log file and prints the results. First, it prints a list of webpages with most page views, ordered from most pages views to less and then prints a list of webpages with most unique page views, ordered as well. 

## The log file
The log file that is going to be parsed must have the following format:
```
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
```

## Usage
To use the parser you should have installed the *ruby-2.3.1*.

To parse a log file type from the root folder:
```
ruby parser.rb path/to/logfile
``` 

## Testing
The application is fully unit tested, using Rspec. To run the test suite type in your terminal:

```
rspec spec
```

## License
The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
