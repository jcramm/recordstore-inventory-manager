#!/usr/bin/env ruby
require './lib/csv_import'

file_path = ARGV.first
Import.import(file_path)