[![Build Status](https://travis-ci.org/ggeldenhuis/puppet-dataexample.svg?branch=master)](https://travis-ci.org/ggeldenhuis/puppet-dataexample)
# puppet-dataexample
I wrote this module to help me traverse data in modules and to a lesser extend
hiera5. If you find this usefull then please let me know and if you feel that
something is sorely missing then file a bug or submit a PR. This module is also
to a lesser extend a way of documenting some design _principles_ used in module
design. There is no ultimate module that all other modules are based on, this is
perhaps my attempt at my own personal ultimate module.

## Data
The idea of data in modules is to allow you to add a hiera hierarchy for the
module only. So instead of having _if_ or _case_ statements in your params.pp
class you move your logic for data into hiera. So in the same way that you would
use facts in your normal hierarchy you would use facts here to make a choice
between whether setting the variable for CentOS or Red Hat as an example.

## Inheritance
Inheritance in the context of modules have traditionally been used when using
the params pattern. That allows you to access variables in a class with the
local variable name. Inheritance also determines evaluation order of code in
puppet. If your class is inheriting from params.pp then params.pp will be
evaluated first and when you access variables in the inherited class then they
will definitely have a value if params.pp set a value.

## Ordering
Consider the following code snippets:
```
myclass {
  contain myclass::install
  contain myclass::config
  contain myclass::service
  Class[‘myclass::install’]
  -> Class[‘myclass::config’]
  ~> Class[‘myclass::service’]
}
```
VS
```
myclass {
  class { ‘myclass::install’ } ->
  class { ‘myclass::config’} ~>
  class { ‘myclass::service’}
}
```
In the first snippet we _contain_ the classes ```myclass::install```,
```myclass::config``` and ```myclass::service``` within ```myclass```. We then
set the class relationship by referencing class resources.

In the second snippet, we add three class resources to ```myclass``` and set the
ordering between classes. If we were to only ever use myclass on it's own then
the second snippet would be more elegant and we would have less lines of code.
However if you were to do something like the following:
```class { 'myclass': } -> class { 'foo': }``` then any resources within
```myclass::install```, ```myclass::config``` or ```myclass::service``` would
potentially _float_ away in the puppet catalogue. In other words your
relationship between _foo_ and _myclass_ is only between resources directly
within those classes. Even though a class is called a resource in this case it
really is second class citizen with regards to ordering.


## Some more reading
* [Hiera 5 Documentation](https://puppet.com/docs/puppet/5.3/hiera_config_yaml_5.html)
* [Class containment](https://puppet.com/docs/puppet/5.3/lang_containment.html)
