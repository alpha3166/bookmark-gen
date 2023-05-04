class Bookmark
  def initialize(chunk, mtime)
    @name = chunk.sub(/^# /, "")
    @mtime = mtime
    @categories = []
    @preferred_categories = []
  end
  attr(:name, :mtime)
  attr_accessor(:categories, :preferred_categories)
end

class Category
  @@num = 0
  def initialize(chunk)
    @@num += 1
    @id = "c#{@@num}"
    @name = chunk.sub(/^## /, "")
    @groups = []
  end
  attr(:id, :name)
  attr_accessor(:groups)
end

class Group
  @@num = 0
  def initialize(chunk)
    @@num += 1
    @id = "g#{@@num}"
    @name = chunk.sub(/^### /, "")
    @sites = []
  end
  attr(:id, :name)
  attr_accessor(:sites)
end

class Site
  def initialize(chunk)
    lines = chunk.split("\n")
    @main_page = Page.new(lines.shift, lines.shift)
    @sub_pages = []
    while lines.size >= 2
      sub_page = Page.new(lines.shift, lines.shift)
      @sub_pages.push(sub_page)
    end
    if lines.size == 1
      @comment = lines.shift
    end
  end
  attr(:main_page, :sub_pages, :comment)
end

class Page
  def initialize(name, url)
    @name = name
    @url = url
  end
  attr(:name, :url)
end

def parse(filename)
  bookmark = nil
  current_category = nil
  current_group = nil
  File.read(filename).split("\n\n") do |chunk|
    if chunk.start_with?("# ")
      bookmark = Bookmark.new(chunk, File.mtime(filename))
    elsif chunk.start_with?("## ")
      current_category = Category.new(chunk)
      bookmark.categories.push(current_category)
      current_group = nil
    elsif chunk.start_with?("### ")
      current_group = Group.new(chunk)
      current_category.groups.push(current_group)
    elsif chunk == "---"
      bookmark.preferred_categories = bookmark.categories
      bookmark.categories = []
    else
      if current_group == nil
        current_group = Group.new("")
        current_category.groups.push(current_group)
      end
      current_group.sites.push(Site.new(chunk))
    end
  end
  return bookmark
end
