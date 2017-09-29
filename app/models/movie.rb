class Movie < ActiveRecord::Base
    
    #method to pick out the unique ratings from the movies
    def self.ratings
        Movie.select(:rating).map(&:rating).uniq
    end
    
end
