# opsview_rest
[![Build Status](https://api.travis-ci.org/cparedes/opsview_rest.png)](https://travis-ci.org/cparedes/opsview_rest)

A Ruby Gem that allows you to interact with an Opsview server.

## License

Apache 2.0.

## Resources

This gem is heavily based off of Adam Jacob's "dynect_rest" gem.

First iteration will focus on creating/updating/deleting resources on an
Opsview server.  The following resources are currently supported (you would
enter these types in as parameter :type in "create", "purge", and "list"):

* attribute
* contact
* host
* hostcheckcommand
* hostgroup
* hosttemplate
* keyword
* monitoringserver
* notificationmethod
* role
* servicecheck
* servicegroup
* timeperiod

Check out [http://docs.opsview.com/doku.php?id=opsview-community:restapi:config](http://docs.opsview.com/doku.php?id=opsview-community:restapi:config)
for a list of possible parameters to pass in to each resource type.

Keep in mind that in general, you can pass in just the name of an object that
is a dependency for the object you're creating, and the library should figure
out the best way to map those resources in the right way to send to the Opsview
Server.  For example, for a "host" resource, you can pass in an array of
hosttemplates that you want to apply to a host - you can specify the list of
hosttemplates like this:

```ruby
connection.create(:type => host,
                  :name => "foobar",
                  :hosttemplates => [ "ht1", "ht2" ],
                  )
```

and the library will properly format the payload in JSON like this:

```ruby
{
  "name": "foobar",
  "hosttemplates": [
    { "name": "ht1" },
    { "name": "ht2" }
  ]
}
```

There's a few that might not do this by default, since the API requires a bit
more information than can be implied by just a list of names.  I'm still
looking for a good way to represent this data, so if anyone has any great
ideas, I'm all ears.

One good example of what I'm talking about is the "notificationprofiles"
parameter for the "contacts" resource (look at
http://docs.opsview.com/doku.php?id=opsview-community:restapi:config#contacts
for an example): there's a lot of information that seems to be better served by
instantiating a "Notification Profiles" object and embedding it within the
payload.  Again, not too sure how to handle this gracefully other than having
the user just pass in the array with all of the parameters manually.

Anyway, this is how you would use the gem to create a resource:

```ruby
require 'opsview_rest'

connection = OpsviewRest.new("http://127.0.0.1/", :username => "admin", :password => "initial")

host = connection.create(
  :name => "foobar",
  :ip => "192.168.1.2",
  :hostgroup => "Monitoring Servers",
  :hosttemplates => [ "OS - Unix Base", "Network - Base" ],
  :type => :host,
  :replace => false

)

# Let's say we want to peer into what we have so far for hosts:

connection = Opsview.new(...)
hosts = connection.list(:type => "host")

# And what if we knew the name of the server and wanted to delete it?

connection = Opsview.new(...)
connection.purge(:type => "host", :name => "foobar")
```
