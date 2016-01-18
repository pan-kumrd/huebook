class UserReferenceSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name,
               :last_name,
               :profile_picture_file_name
end
