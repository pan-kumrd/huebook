class WallReferenceSerializer < ActiveModel::Serializer
    attributes :id,
               :type,
               :name

    def type
        if object.is_a? User then
            'user'
        else
            'event'
        end
    end

    def name
        if object.is_a? User then
            sprintf('%s %s', object.first_name, object.last_name)
        else
            object.name
        end
    end
end
