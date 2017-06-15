Kele is a Ruby Gem that provides programmatic access to the Bloc student API. 

## To install Kele

1. Create a .env file with the lines: EMAIL=... and PASSWORD=... (filled in with the email and password used for your Bloc account)
2. Add "gem kele" to the Gemfile for your Ruby program.

## To use Kele

Add the following lines to your Ruby class:
```
require 'kele'
include 'Kele'
```

## Kele functionality

### To create a new kele object

```
kele = Kele.new(email, password)
```

### To download your user information:

```
info = kele.get_me
```

By default, Kele will cache this information. If you want to make sure that your information is recent, you use

```
info = kele.get_me(true)
```

to force a refetch.

### To get your mentor id:

```
id = kele.get_mentor_id
```

### To get your roadmap id:

```
id = kele.get_roadmap_id
```


### To get your enrollment id:

```
id = kele.get_enrollment_id
```

### To get your mentor availability:

```
avail = kele.get_mentor_availability
```

### To get a list of your messages

```
messages = kele.get_messages(page_num)
```

(The messages are grouped into pages; this returns a specific page worth of messages)

### To send a message

```
kele.create_message(recipient_id, subject, text, token)
```

where `token` is the token associated with the thread you want the message to be added to (or nil if it's to begin a new thread).

### To get the roadmap

```
roadmap = kele.get_roadmap
```

### To get a particular checkpoint

```
checkpoint = kele.get_checkpoint(id)
```

where `id` is the id of the checkpoint.

### To submit a completed checkpoint

```
create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, update_id)
```

where `update_id` is the id of the previous submission, if you are updating, or nil if this is the first submission to this checkpoint.


