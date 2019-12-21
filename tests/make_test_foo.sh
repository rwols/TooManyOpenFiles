
cat << EOF > test_foo.py
from UnitTesting import DeferrableTestCase
import sublime


class FooTest(DeferrableTestCase):

    def setUp(self):
        self.view = sublime.active_window().new_file()

    def tearDown(self):
        yield 0
        self.view.set_scratch(True)
        self.view.close()

EOF

for ((i = 0; i != 5000; i++)); do
    printf "    def test_%i():\n        pass\n" $i >> test_foo.py
done
