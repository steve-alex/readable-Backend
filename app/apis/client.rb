require 'unirest'

class Client
  @@API_ENDPOINT = "https://www.googleapis.com/books/v1/volumes?q="

  def initialize(query="", method="intitle", max_results=10)
    @API_key = ENV["API_KEY"]
    @search_term = "#{@@API_ENDPOINT}#{method}:#{query}&maxResults=#{max_results}&key=#{@API_key}"
  end

  def get_search_data
    book_data = api_results()
    build_book_hash(book_data)
  end

  def api_results
    Unirest.get(@search_term).body["items"]
  end

  def build_book_hash(api_results)
    books_array = []
    if api_results
      api_results.each do |book_data|
        books_array << create_book_item(book_data)
      end
    end
    books_array
  end

  def create_book_item(book_data)
    book = {}
    book["google_id"] = book_data["id"]
    book["title"] = book_data["volumeInfo"]["title"]
    book["subtitle"] = book_data["volumeInfo"]["subtitle"]
    book["authors"] = parse_array(book_data["volumeInfo"]["authors"]) #Make this a string
    book["categories"] = parse_array(book_data["volumeInfo"]["categories"]) #Slice this into different genres
    book["description"] = book_data["volumeInfo"]["description"]
    book["language"] = book_data["volumeInfo"]["language"]
    book["image_url"] = verify_image(book_data)
    book["published_date"] = book_data["volumeInfo"]["publisheddate"]
    book["page_count"] = book_data["volumeInfo"]["pageCount"]
    book["google_average_rating"] = book_data["volumeInfo"]["averageRating"] #Check if this exists
    book["rating_count"] = book_data["volumeInfo"]["ratingsCount"]
    book
  end

  def parse_array(array)
    if array
      array.join(", ")
    else
      nil
    end
  end
  
  def verify_image(book_data)
    if book_data["volumeInfo"]["imageLinks"]
      return book_data["volumeInfo"]["imageLinks"]["thumbnail"]
    else
      return nil
    end
  end

end