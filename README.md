# Introduction

This project will search for any text inside all files in specified directory (*recursively*)

# How to use it

This script accepts 2 arguments:

1. Directory in which files will be searched (*required*)
1. Text to search (for example: `TODO`) (*required*)

It will output error if arguments are missing, or directory is not exist, or text to search is empty.

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
$ ruby text_finder.rb sample t
sample/somedir/somemodule/somefile.js
  3: todo
  7: jgvhsdsgtjt
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

Just fork this repo and submit a Merge Request.
