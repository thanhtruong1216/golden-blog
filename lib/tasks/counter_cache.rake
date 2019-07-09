desc 'Counter cache for post has many comments'

task comment_counter: :environment do
  Post.reset_column_information
  Post.pluck(:id).each do |id|
    Post.reset_counters id, :comments
  end
end

desc 'Counter cache for post has many likes'

task like_counter: :environment do
  Post.reset_column_information
  Post.pluck(:id).each do |id|
    Post.reset_counters id, :likes
  end
end
