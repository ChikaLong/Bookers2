class SearchesController < ApplicationController
  
  def search
    @model=params["model"]
    @content=params["content"]
    @method=params["method"]
    @records=search_for(@model, @content, @method)
  end
  
  private
  
  def perfect(model, content)
    if model == 'user'
      User.where(name: content)
    elsif model == 'book'
      Book.where(title: content)
    end
  end
  
  def forward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{content}%")
    end
  end
  
  def backward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}")
    end
  end
  
  def partial(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}%")
    end
  end
  
  def search_for(model, content, method)
    case method
    when 'perfect'
      perfect(model, content)
    when 'forward'
      forward(model, content)
    when 'backward'
      backward(model, content)
    when 'partial'
      partial(model, content) 
    end
  end
  
end
