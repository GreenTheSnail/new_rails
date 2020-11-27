namespace :fakedata do
  desc "Test data generation"
  task generate: :environment do
    email = 'test@gmail.com'
    userName = 'test'
    pass = 'Test123'

    user = User.new(:email => email, :username => userName, password: pass, password_confirmation: pass)
    user.save

    if (user.id)

      tags = []
      50.times do |i|
        tag = Tag.new(:title => 'tag ' + i.to_s, :color => '#%06x'%(rand*0xffffff), :user_id => user.id)
        tag.save
        tags << tag
      end

      categories = []
      20.times do |i|
        category = Category.new(:title => 'category ' + i.to_s, :color => '#%06x'%(rand*0xffffff), :user_id => user.id)
        category.save
        categories << category
      end

      400.times do |i|

        task = Task.new(:deadline_at => Time.now + 60*i, :title => 'task ' + i.to_s, :note => 'note ' + i.to_s, :user_id => user.id)
        # cate
        customRand = rand(0..19)
        if (customRand != 0)
          task.category_id = categories[customRand].id
        end

        task.save

        # tags
        customRandTags = rand(0..10)
        tag_ids = Tag.pluck(:id)
        customRandTags.times do |t|
          rand_id = tag_ids.sample
          tag = TagAssociation.new(:task_id => task.id, :tag_id => tag_ids.delete(rand_id))
          tag.save
        end
      end

      p "User with 400 task, 50 tags, 20 categories"
      p "Login: #{email}"
      p "Password: #{pass}"


    else

      p "user already exist in database :email => #{email}, :userName => #{userName}"
    end
  end
  end
