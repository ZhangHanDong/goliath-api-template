module All
  class << self
    def initialize!
      load_lib
      load_models
      load_models_ext
      load_helpers
      load_middlewares
      # load_entities
      load_apis
      load_jobs
      load_workers
    end

    private

    def load_models

      require Goliath.root_path("app/models/concerns/conversion")
      require Goliath.root_path("app/models/report")
      require Goliath.root_path("app/models/category")
      require Goliath.root_path("app/models/post")
      require Goliath.root_path("app/models/credit")
      require Goliath.root_path("app/models/comment")

      Dir[Goliath.root_path("app/models/concerns/*.rb")].each {|model| require model }
      Dir[Goliath.root_path("app/models/*.rb")].each {|model| require model }
    end

    def load_models_ext
      Dir[Goliath.root_path("app/models_ext/concerns/*.rb")].each {|model_ext| require model_ext }
      Dir[Goliath.root_path("app/models_ext/*.rb")].each {|model_ext| require model_ext }
    end

    def load_helpers
      Dir[Goliath.root_path("app/helpers/**/*.rb")].each {|helper| require helper }
    end

    def load_apis
      Dir[Goliath.root_path("app/apis/concerns/*.rb")].each {|concern| require concern }
      Dir[Goliath.root_path("app/apis/**/*.rb")].each {|api| require api }
    end

    def load_lib
      Dir[Goliath.root_path("lib/**/*.rb")].each {|lib| require lib }
    end

    def load_middlewares
      Dir[Goliath.root_path("app/middlewares/**/*.rb")].each {|middleware| require middleware }
    end

    ### obsolete
    # def load_entities
    #   Dir[Goliath.root_path("app/entities/**/*.rb")].each {|entity| require entity }
    # end

    def load_jobs
      Dir[Goliath.root_path("app/jobs/**/*.rb")].each {|job| require job }
    end

    def load_workers
      Dir[Goliath.root_path("app/workers/**/*.rb")].each {|worker| require worker }
    end

  end
end

All.initialize!
