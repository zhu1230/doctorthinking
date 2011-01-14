module SharedResourcesHelper
def last_resource
	SharedResource.by_created_at.limited(5)
end

def hot_down_resource
	SharedResource.by_down_count.limited(5)
end
def hot_view_resource
	SharedResource.by_page_views_count.limited(5)
end
def last_resource_by_category(c)
	SharedResource.category_equals(c).by_created_at.limited(5)
end


end