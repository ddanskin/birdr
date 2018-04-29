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
        Post.where(user_id: user_id)
    end
end
