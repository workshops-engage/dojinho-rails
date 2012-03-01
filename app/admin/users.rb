ActiveAdmin.register User do
  
  index do
    column :name
    column :email
  end
  
  filter :name
  filter :email

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :password
    end
    f.buttons
  end

end
