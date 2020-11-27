class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_destroy :destroyAll
  after_create :createTestData
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :tags, dependent: :destroy
           has_many :categories, dependent: :destroy
           has_many :tasks, dependent: :destroy


  def createTestData
    if self.id
      @category1 = Category.new(:title => 'Osobní', :color => '#8B0000', :user_id => self.id)
      @category1.save
      @category2 = Category.new(:title => 'Škola', :color => '#228B22', :user_id => self.id)
      @category2.save
      @category3 = Category.new(:title => 'Práce', :color => '#000080', :user_id => self.id)
      @category3.save

      @tag1 = Tag.new(:title => 'UCL', :color => '#ADFF2F', :user_id => self.id)
      @tag1.save
      @tag2 = Tag.new(:title => 'JSE', :color => '#FF0000', :user_id => self.id)
      @tag2.save
      @tag3 = Tag.new(:title => 'WEB', :color => '#FF1493', :user_id => self.id)
      @tag3.save
      @tag4 = Tag.new(:title => '3DT', :color => '#FF6347', :user_id => self.id)
      @tag4.save
      @tag5 = Tag.new(:title => 'PR1', :color => '#20B2AA', :user_id => self.id)
      @tag5.save
      @tag6 = Tag.new(:title => 'PES', :color => '#00FFFF', :user_id => self.id)
      @tag6.save
      @tag7 = Tag.new(:title => 'Nákupy', :color => '#4682B4', :user_id => self.id)
      @tag7.save
      @tag8 = Tag.new(:title => 'Wishlist', :color => '#BDB76B', :user_id => self.id)
      @tag8.save

      @task1 = Task.new(:deadline_at => Time.now + 60*1, :title => 'Jednoduchý', :note => 'Toto je jednoduchý úkol', :user_id => self.id)
      @task1.save
      @task2 = Task.new(:deadline_at => Time.now + 60*2, :title => 'Dokončený', :note => 'Toto je už dokončený úkol', :is_done => 1,  :user_id => self.id)
      @task2.save
      @task3 = Task.new(:deadline_at => Time.now + 60*3, :title => 'Nakoupit', :note => 'Nakoupit na večeři', :category_id => @category1.id, :user_id => self.id)
      @task3.save
      @tag_ass1 = TagAssociation.new(:task_id => @task3.id, :tag_id => @tag7.id)
      @tag_ass1.save
      @task4 = Task.new(:deadline_at => Time.now + 60*4, :title => 'Semestrální práci', :note => 'Udělat semestrální práci z předmětu WEB', :category_id => @category2.id, :user_id => self.id)
      @task4.save
      @tag_ass2 = TagAssociation.new(:task_id => @task4.id, :tag_id => @tag1.id)
      @tag_ass2.save
      @tag_ass3 = TagAssociation.new(:task_id => @task4.id, :tag_id => @tag3.id)
      @tag_ass3.save
    end
  end
end
