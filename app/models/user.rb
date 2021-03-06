class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :token, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def repos
    service = GithubService.new(self)
    json = service.git_repos
    list = []
    (1..5).each do |count|
      list << json[count][:full_name]
    end
    list
  end

  def followers
    service = GithubService.new(self)
    json = service.git_followers
    json.map { |person| person[:login] }
  end

  def following
    service = GithubService.new(self)
    json = service.git_following
    json.map { |person| person[:login] }
  end

  def self.omniauth_token(auth_info)
    auth_info.credentials.token
  end

  def self.omniauth_username(auth_info)
    auth_info.extra.raw_info.login
  end

  def can_friend(github_username)
    if User.exists?(username: github_username)
      user = User.find_by(username: github_username)
      check = "#{user.first_name} #{user.last_name}"
      true unless friends.include?(check)
    end
  end

  def name(github_username)
    user = User.find_by(username: github_username)
    "#{user.first_name}-#{user.last_name}"
  end

  def bookmarked_vids
    videos.order(:tutorial_id, :position)
  end
end
