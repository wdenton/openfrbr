class Expression < ActiveRecord::Base

  validates_presence_of :title, :message => "cannot be blank"
  validates_presence_of :language, :message => "cannot be blank"
  # validates_presence_of :form, :message => "cannot be blank"

  has_one :reification
  has_one :work, :through => :reifications

  has_many :embodiments
  has_many :manifestations, :through => :embodiments

  has_many_polymorphs :realizers, :from => [:people, :families, :corporate_bodies], :through => :realizations

  has_many :works, :as => :subject

  def anchor_text
    # Used to have form in here too, to disambiguate
    title + " (" + language + ", " + embodiments.size.to_s + " m)"
    # title + " (" + language + ", " + form + "/" + manifestations.size.to_s + ")"
  end

  # def work
  #   # For expression e, e.work a Work object representing
  #   # the first Work for which this Expression is a reification.
  #   # (And only, if there is just one.)
  #   Work.find(reifications[0].work_id)
  # end

  # def works
  #   # For expression e, e.works returns an array of all works
  #   # for which e is a reification.
  #   works = []
  #   reifications.each { |r| works << Work.find(r.work_id) }
  #   works
  # end

  def has_relation_to_work(work_id)
    # Return relation of expression to work with given ID.
    # TODO: Better error-handling if there is no relation
    Reification.find_by_work_id(work_id, :conditions => "expression_id = #{id}").relation
  end

end

