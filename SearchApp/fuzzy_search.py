from django.db.models.query import QuerySet

#  On Windows the Visual C++ 2019 redistributable is required
from rapidfuzz import fuzz as search


def fuzzy_search(search_query: str, model_objects: QuerySet, field: str = "title", ratio: int = 60) -> list:
    search_result = [
        model_object for index, model_object in enumerate(model_objects)
        if search.ratio(search_query, getattr(model_objects[index], field, "title")) >= ratio
    ]
    return search_result
