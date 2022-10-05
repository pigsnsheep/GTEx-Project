import pandas as pd
from cmapPy.pandasGEXpress.parse_gct import parse
from cmapPy.pandasGEXpress.write_gct import write

data = pd.DataFrame(parse("dataset.gct"))

print("hello world")
