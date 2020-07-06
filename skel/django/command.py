from django.core.management.base import BaseCommand


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('foo', nargs=1, default=1, type=int)
        parser.add_argument('--bar', nargs='*')

    def handle(self, **options):
        pass
