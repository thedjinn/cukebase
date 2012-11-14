# Cukebase

This gem provides integration betweeen Cucumber and the Codebase ticketing
system. Whenever scenarios are run Cukebase will create tickets for any
scenarios it encounters. It sets the ticket status to the test result of the
scenario.

When you run Cucumber again, these tickets are updated to reflect the new
result status.

## Usage

Add this to your Gemfile:

```ruby
group :test do
  gem 'cukebase'
end
```

Then go to Codebase to find your API credentials and add the following to your
`features/support/env.rb` file:

```ruby
Cukebase.config do |c|
  c.project = "your-project-name"
  c.username = "yourcompany/youruser"
  c.api_key = "YOUR_API_KEY"
end
```

And next time when you run Cucumber, there will be tickets made for every
scenario.

## Future work

Here are some ideas you can send pull requests for:

* Add an option to enable/disable Cukebase, e.g. to run it only on a CI server
  but not on your development machine.
* Add the ability to read credentials from a file.
* Mark tickets as obsolete when a scenario is removed instead of being
  completed.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Cukebase is MIT-licensed. I'm sure you can find a copy somewhere if you aren't
able to recite it by heart.
