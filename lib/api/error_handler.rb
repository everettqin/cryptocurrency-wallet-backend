module API
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do

          rescue_from ActiveRecord::RecordNotFound do |e|
            respond(:record_not_found, 404, e)
          end


          rescue_from ActiveRecord::RecordInvalid do |e|
            respond(:unprocessable_entity, 422, e)
          end


          rescue_from ActiveRecord::DeleteRestrictionError do |e|
            respond(:unprocessable_entity, 422, e)
          end

          ## show 500 error reason in test
          unless Rails.env == 'test' or Rails.env == 'development'
            rescue_from StandardError do |e|
            respond(:standard_error, 500, e)
          end
        end
      end
    end

    private

    def respond(_error, _status, _messages)
      @render = render json: {
        errors: _messages
      }, status: _status
    end
  end
end
