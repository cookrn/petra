# Petra

A toolkit for managing Ansible/Vagrant projects.

## Installation

Run the following command on your shell to install the gem, including
the CLI.

    gem install petra

## Usage

Start by creating a new project:

    petra generate project my-sweet-project

Or, use the shortcut:

    petra new my-sweet-project

This includes a default machine configuration with the name `default`.
Machines are Petra's way of describing the different (proto)types of
boxes that your project may need. If you want to call it `webserver`
instead, use the `-m` option:

    petra new my-sweet-project -m webserver

When you're ready, `cd` into your project and run `vagrant up`.

That's all for now :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
