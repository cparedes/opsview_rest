TODO List
=========

1. Figure out a way to instantiate a ton of methods for all of the different
   resource types.  There isn't a nice way to deal with, say, hosts, and
   hostgroups at the moment (since they all have different parameters.)
   The only things that are common between the different resource types
   are "name" and "id".
1a. If not this, then there should be a better way to deal with the plethora
    of fields that we could possibly update in Opsview for each resource type.
    I've mostly based the code off of Adam Jacob's dynect_rest gem, which
    has a much simpler API and a predictable set of parameters - thus, it
    makes sense to dynamically create a ton of methods and allow stuff like
    "dynect.record.ip.foobar" as an accessor.

    One thought is to simply choose a functional subset of the parameters we
    could pass into each type of resource, and add more as the need arises.
    Another thought is to simply pass in a hash with a bunch of data in it,
    but I'd rather not do this, as it'd make the user guess how best to format
    the data.
