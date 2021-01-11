require 'rails_helper'

RSpec.describe "Cats", type: :request do

  # index
  it 'gets a list of Cats' do
    # Creating an instance of a new cat
    Cat.create(name: 'Moe', age: 5, enjoys: 'Eating all the food.')

    # Make a request to the API
    get '/cats'

    cats = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(cats.length).to eq 1

  end

  # create
  it 'creates a new cat' do
    cat_params = {
      cat: {
        name: 'Larry',
        age: 8,
        enjoys: 'Sleeping'
      }
    }

    # Make a request to the API
    post '/cats', params: cat_params

    expect(response).to have_http_status(200)

    cat = Cat.first
    expect(cat.name).to eq 'Larry'

  end

end
