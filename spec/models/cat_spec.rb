require 'rails_helper'

RSpec.describe Cat, type: :model do

  it 'should have a valid name' do
    cat = Cat.create(age: 4, enjoys: 'Walks on the beach')
    expect(cat.errors[:name]).to include "can't be blank"
  end

  it 'should have a valid age' do
    cat = Cat.create(name: 'Neil', enjoys: 'Walks on the beach')
    expect(cat.errors[:age]).to include "can't be blank"
  end

  it 'should have a valid enjoys' do
    cat = Cat.create(name: 'Neil', age: 4)
    expect(cat.errors[:enjoys]).to include "can't be blank"
  end

  it 'should have an enjoys attribute with at least 10 characters' do
    cat = Cat.create(name: 'Felix', age: 7, enjoys: 'Walks')
    expect(cat.errors[:enjoys]).to include "is too short (minimum is 10 characters)"
  end

end
