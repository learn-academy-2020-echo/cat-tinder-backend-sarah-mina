require 'rails_helper'

RSpec.describe "Cats", type: :request do

  # index
  it 'gets a list of Cats' do
    # Creating an instance of a new cat
    Cat.create(name: 'Moe', age: 5, enjoys: 'Eating all the food.')

    # Make a request to the API
    get '/cats'
    cats = JSON.parse(response.body)

    expect(cats.length).to eq 1
    expect(response).to have_http_status(200)
  end

  # create
  it 'creates a new cat' do
    cat_params = {
      cat: {
        name: 'Larry',
        age: 8,
        enjoys: 'Sleeping on your face'
      }
    }
    # Make a request to the API
    post '/cats', params: cat_params
    cat = Cat.first

    expect(cat.name).to eq 'Larry'
    expect(response).to have_http_status(200)
  end

  # update
  it 'edits a cat' do
    cat_params = {
      cat: {
        name: 'Felix',
        age: 4,
        enjoys: 'Walks in the park.'
      }
    }
    post '/cats', params: cat_params
    cat = Cat.first

    new_cat_params = {
      cat: {
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park.'
      }
    }
    patch "/cats/#{cat.id}", params: new_cat_params
    cat = Cat.find cat.id

    expect(cat.age).to eq 2
    expect(response).to have_http_status(200)
  end


  # delete
  it 'deletes a cat' do
    cat_params = {
      cat: {
        name: 'Felix',
        age: 4,
        enjoys: 'Walks in the park.'
      }
    }
    post '/cats', params: cat_params
    cat = Cat.first
    delete "/cats/#{cat.id}"
    cats = Cat.all

    expect(cats).to be_empty
    expect(response).to have_http_status(200)
  end

  it 'cannot create a new cat without a name' do
    cat_params = {
      cat: {
        age: 8,
        enjoys: 'Sleeping on your face'
      }
    }
    post '/cats', params: cat_params
    json = JSON.parse(response.body)

    expect(json['name']).to include "can't be blank"
    expect(response).to have_http_status(422)
  end

  it 'cannot create a new cat without an age' do
    cat_params = {
      cat: {
        name: 'Neil',
        enjoys: 'Watching the goldfish bowl'
      }
    }
    post '/cats', params: cat_params
    json = JSON.parse(response.body)

    expect(json['age']).to include "can't be blank"
    expect(response).to have_http_status(422)
  end

  it 'cannot create a new cat without an enjoys' do
    cat_params = {
      cat: {
        name: 'Neil',
        age: 4
      }
    }
    post '/cats', params: cat_params
    json = JSON.parse(response.body)

    expect(json['enjoys']).to include "can't be blank"
    expect(response).to have_http_status(422)
  end

end
