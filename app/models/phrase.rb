class Phrase < ActiveRecord::Base
  belongs_to :language
  validates :phrase, :language, :presence => true

  attr_taggable :categories

  has_many :transforms
  has_many :transformations, :through => :transforms, :source => :transformation
  has_many :inverse_transforms, :class_name => "Transform", :foreign_key => "transformation_id"
  has_many :inverse_transformations, :through => :inverse_transforms, :source => :phrase

  # Returns this phrase as a structure optimized
  # for dense packing as JSON. An array with two
  # values, the first being the phrase and the
  # second one a list of translations.
  def to_question_js tags = nil
    answers = tags ?
            translations.tagged_with(tags) :
            translations
    [
      phrase,
      translations.length == 1 ?
        translations.first.phrase :
        translations.collect { |t| t.phrase }
    ]
  end

  class CompositeCollection
    include Enumerable

    def initialize first_collection, second_collection
      @first, @second = first_collection, second_collection
    end

    def [] a,*b
      (@first + @second)[a,*b]
    end

    def each &b
      @first.each &b
      @second.each &b
    end

    def << object
      @first << object
    end

    def push object
      self << object
    end

    def concat object
      self << object
    end
    
    def delete object, *etc
      @first.delete object, *etc
      @second.delete object, *etc
    end

    def delete_all
      @first.delete_all
      @second.delete_all
    end

    def destroy_all
      @first.destroy_all
      @second.destroy_all
    end

    def clear
      @first.clear
      @second.clear
    end

    def empty?
      @first.empty? and @second.empty?
    end

    def size
      @first.size + @second.size
    end

    def length
      size
    end

    def count
      size
    end

    def find object
      begin
        @first.find(object)
      rescue ActiveRecord::RecordNotFound => e
        @second.find(object)
      end
    end

    def exists? object
      @first.exists?(object) or @second.exists?(object)
    end

    def build attributes = {}, *etc
      @first.build attributes, *etc
    end

    def create attributes = {}
      @first.create attributes
    end

    def create! attributes = {}
      @first.create! attributes
    end
  end

  def all_transforms force_reload = false
    CompositeCollection.new(transforms(force_reload),
                            inverse_transforms(force_reload))
  end

  def all_transforms= objects
    transforms = objects
    inverse_transforms = []
  end

  def all_transforms_singular_ids
    transforms_singular_ids + inverse_transforms_singular_ids
  end

  def all_transforms_singular_ids= ids
    transforms_singular_ids= ids
    inverse_transforms_singular_ids= []
  end

  def translations force_reload = false
    CompositeCollection.new(transformations(force_reload),
                            inverse_transformations(force_reload))
  end

  def translations= objects
    transformations = objects
    inverse_transformations = []
  end

  def translations_singular_ids
    transformations_singular_ids + inverse_transformations_singular_ids
  end

  def translations_singular_ids= ids
    transformations_singular_ids= ids
    inverse_transformations_singluar_ids= []
  end
end
