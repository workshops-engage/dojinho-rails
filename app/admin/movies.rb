ActiveAdmin.register Movie do

  index do
    column :title
    column :imdb_id
    column :url
    column :points
  end  

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :imdb_id
      f.input :url
    end
    f.buttons
  end

end
