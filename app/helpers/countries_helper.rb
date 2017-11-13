module CountriesHelper
  def states_collection
    ::Country['US'].states.map { |s| [ s[1]['name'], s[1]['name'], { :'data-show' => 'US' } ] } +
    ::Country['BR'].states.map { |s| [ s[1]['name'], s[1]['name'], { :'data-show' => 'BR' } ] }
  end
end
