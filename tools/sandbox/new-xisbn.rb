#!/usr/bin/ruby -w

require 'uri'
@@oclc_uri = URI.parse('http://old-xisbn.oclc.org/webservices/xisbn')
@@thing_uri = URI.parse('http://www.librarything.com/api/thingISBN')

def xisbn(isbn, opts={})
  return get_isbns(@@oclc_uri, isbn, opts)
  # If only one ISBN is returned, we can't be sure whether it's
  # a singleton or unknown to WorldCat.  We need to do a further
  # check to find out.
  http = Net::HTTP.new(uri.host)
  http.read_timeout = timeout
  http.open_timeout = timeout
  response = http.get("#{uri.path}/#{clean_isbn}")

  # follow HTTP redirects
  if response.kind_of?(Net::HTTPRedirection)
    return get_isbns(URI.parse(response['location']), isbn,
                     {:timeout => timeout, :redirects => (redirects-1)})
  end

  isbns = []
  doc = REXML::Document.new(response.body)
  doc.elements.each('idlist/isbn') {|e| isbns << e.text}
  return isbns

end

def thing_isbn(isbn, opts={})
  return get_isbns(@@thing_uri, isbn, opts)
end

private

def get_isbns(uri, isbn, opts={})
  timeout = opts[:timeout] || 60
  redirects = opts[:redirects] || 10
  clean_isbn = isbn.gsub(/[^0-9X]/,'')

  # base case for http redirect recursion
  raise ArgumentError, 'Too many redirects' if redirects == 0

  http = Net::HTTP.new(uri.host)
  http.read_timeout = timeout
  http.open_timeout = timeout
  response = http.get("#{uri.path}/#{clean_isbn}")

  # follow HTTP redirects
  if response.kind_of?(Net::HTTPRedirection)
    return get_isbns(URI.parse(response['location']), isbn,
                     {:timeout => timeout, :redirects => (redirects-1)})
  end

  isbns = []
  doc = REXML::Document.new(response.body)
  doc.elements.each('idlist/isbn') {|e| isbns << e.text}
  return isbns
end
