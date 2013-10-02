require 'awesome_print'
# Version-sorted strings are compared such that if ver1 and ver2 are version
# numbers and prefix and suffix (suffix matching the regular
# expression ‘(\.[A-Za-z~][A-Za-z0-9~]*)*’) are strings then ver1 < ver2
# implies that the name composed of “prefix ver1 suffix” sorts before
# “prefix ver2 suffix”.

class Array

  def version_sort(prefix, extension)
    clean_array = self.collect { |version| version.gsub(prefix,'').gsub(extension,'') }
    nearly_sorted_array = clean_array.sort_by { |num| [num[/^[^\.]*/].to_i, num[/(?<=\.)(.*?)(?=\.)/].to_i] }
    even_more_sorted_array = []
    nearly_sorted_array.collect { |file| "#{prefix}#{file}#{extension}"}
  end

end


def assert_equal(actual, expected)
  if expected != actual
    puts "Fail...Expected this:"
    ap expected
    puts "Got this instead:"
    ap actual
  else
    "Pass"
  end
end

filenames = [
  "foo-1.10.2.ext",
  "foo-1.11.ext",
  "foo-1.3.ext",
  "foo-1.50.ext",
  "foo-1.8.7.ext",
  "foo-1.9.3.ext",
  "foo-1.ext",
  "foo-10.1.ext",
  "foo-10.ext",
  "foo-100.ext",
  "foo-13.ext",
  "foo-2.0.0.ext",
  "foo-2.0.1.ext",
  "foo-2.0.ext",
  "foo-2.007.ext",
  "foo-2.01.ext",
  "foo-2.012b.ext",
  "foo-2.01a.ext",
  "foo-2.0a.ext",
  "foo-2.0b.ext",
  "foo-2.1.ext",
  "foo-25.ext",
  "foo-6.ext",
]
version_sorted_filenames = [
  "foo-1.ext",
  "foo-1.3.ext",
  "foo-1.8.7.ext",
  "foo-1.9.3.ext",
  "foo-1.10.2.ext",
  "foo-1.11.ext",
  "foo-1.50.ext",
  "foo-2.0.ext",
  "foo-2.0a.ext",
  "foo-2.0b.ext",
  "foo-2.0.0.ext",
  "foo-2.0.1.ext",
  "foo-2.01.ext",
  "foo-2.1.ext",
  "foo-2.01a.ext",
  "foo-2.007.ext",
  "foo-2.012b.ext",
  "foo-6.ext",
  "foo-10.ext",
  "foo-10.1.ext",
  "foo-13.ext",
  "foo-25.ext",
  "foo-100.ext",
]

filenames.version_sort('foo-', 'ext')
assert_equal filenames.version_sort('foo-', 'ext'), version_sorted_filenames