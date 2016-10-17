json.array! @sites do |site|
  json.partial! 'api/v1/sites/site', site: site
end
