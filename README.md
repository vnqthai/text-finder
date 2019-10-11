# Introduction

This project will search for any text inside all files in specified directory (*recursively*)

# How to use it

## Prerequisites

* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)

## Description

Syntax

```
ruby text_finder.rb <directory> <text-to-search>
```

This script accepts 2 arguments:

1. Directory in which files will be searched (*required*)
1. Text to search (for example: `TODO`) (*required*)
1. Sensitivity (*optional*):
* The string `sensitive`: case sensitive
* Missing this argument or input anything else: case insensitive (*default*)

It will output error if required arguments are missing, or directory is not exist, or text to search is empty.

## Examples

These example executes for the `sample` directory in this repo

```
$ ruby text_finder.rb sample todo
sample/somedir/somemodule/somefile.js
  3: todo
sample/somedir2/anotherdir/index.js
  2: todo
```

```
$ ruby text_finder.rb sample asdf
sample/somedir/somemodule/somefile.js
  1: asdf
  5: asdf
```

```
$ ruby text_finder.rb sample not_exist
<Output nothing>
```

Case insensitive (default)

```
$ ruby text_finder.rb sample T
sample/somedir/somemodule/somefile.js
  3: toDo
  4: TODO
  6: hgTiur
  7: jgvhsdsgtjt
sample/somedir2/anotherdir/index.js
  2: todo
```

Sensitivity argument is not `sensitive`: case insensitive

```
$ ruby text_finder.rb sample T sen
=> Same as above example
```

Sensitivity argument is exactly `sensitive`: case **sensitive**

```
$ ruby text_finder.rb sample T sensitive
sample/somedir/somemodule/somefile.js
  4: TODO
  6: hgTiur
```

You can change `sample` by `/path/to/text-finder/sample`

# Test it

* Install `rspec`

```
$ gem install rspec
```

* Run tests

```
$ rspec
```


# Contribute

Fork this repo and submit a Merge Request.
