class Base::API < Grape::API
  mount V1::Root
end
