
cat << EOF > test_foo.py
from unittesting import DeferrableTestCase
import sublime


class FooTest(DeferrableTestCase):

    def setUp(self):
        w = sublime.active_window()
        v = w.extract_variables()
        name = sublime.expand_variables("/tests/foo.txt", v)
        self.view = sublime.active_window().open_file(name)

    def tearDown(self):
        yield 0
        self.view.set_scratch(True)
        self.view.close()


EOF

for ((i = 0; i != 5000; i++)); do
    printf "    def test_%i(self):\n        pass\n" $i >> test_foo.py
done
