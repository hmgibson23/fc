# Fyber Offer API  Challenge

Since this was a relatively simple web app I decided to use a small
framework [Cramp](), which I've used in the past and is easy to make
simple asynchronous web applications from. One disadvantage of doing
this is the lack of a proper MVC layout, which might have made
rendering the views and storing the data a little simpler but on the
whole there were not many issues.

I've separated out the to create the hash and also to check the
generated response. There's also some logic here to generate the
parameters from a Ruby hash. Seprating out the concerns allowed me to
unit test these parts of the app. So far I have only written unit
tests but it would make sense to write some integration tests for the application.
