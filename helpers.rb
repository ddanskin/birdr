helpers do
    def h(text)
        Rack::Utils.escape_html(text)
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        User.find(session[:user_id])
    end

    def profile
        Profile.find(session[:user_id])
    end

    def all_posts
        Post.all
    end

    def all_user_posts(user_id)
        Post.where(user_id: user_id).order("created_at DESC").limit(20)
    end

    def posted_by(user_id)
        User.find(user_id).username
    end

    def post_by_id(post_id)
        Post.find_by(id: post_id)
    end

    def create_tags(tag_list, post_id)
        tag_text = tag_list.split(",")
        tag_text.each do |t|
            current = Tag.find_by(text: t)
            if current == nil
                current = Tag.create(text: t)
                current.save!
            end
            new_post_tag = Post_Tag.create(tag_id: current[:id], post_id: post_id)
            new_post_tag.save!
        end
    end
    def delete_tags(posts)
        posts.each do |post|
            Post_Tag.find_by(post_id: post[:id]).destroy
        end
    end
end
