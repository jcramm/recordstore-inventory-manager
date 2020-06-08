#!/usr/bin/env ruby
require './lib/imports/import'

file_path = ARGV.first
Imports::Import.import(file_path)