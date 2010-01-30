module ItemsHelper

  def manifestation(item)
    return Manifestation.find(item.exemplification.manifestation_id)
  end

end
