class V1::Users < Grape::API
  resources :users do

    # 今回paramsが１個しかないけど多い時便利だよ
    helpers do
      def user_params
        ActionController::Parameters.new(params).permit(
          :name,
        )
      end
    end

    # GET /users
    desc 'returns all users' # 説明文が入る
    get '/' do
      users = User.all # 最後に評価された値がレスポンスとして返される
      present user, with: V1::Entities::UserEntity
    end

    # GET /users/1
    desc 'returns an user'
    params do
      requires :id, type: Integer
    end
    get '/:id' do
      user = User.find(params[:id])
      present user, with: V1::Entities::UserEntity
    end

    # POST /users
    desc 'Create an user'
    params do
      requires :name, type: String
    end
    post '/' do
      user = User.create(name: params[:name])
      present user, with: V1::Entities::UserEntity
    end

    # PUT /users/1
    desc 'Update an user'
    params do
      requires :id, type: Integer
    end
    put '/:id' do
      user = User.find(params[:id])
      user.update!(user_params)
      present user, with: V1::Entities::UserEntity
    end

    # DELETE /users/1
    desc 'Delete an user'
    params do
      requires :id, type: Integer
    end
    delete '/:id' do
      user = User.find(params[:id])
      user.destroy
    end
  end
end
