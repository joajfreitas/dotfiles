local function snippet_date (d) 
  return os.date("%Y-%m-%dT%H:%M:%SZ", d) 
end

return {
  s("t0", { f(function () return snippet_date(os.time()) end) }),
  s("t1", { f(function () return snippet_date(os.time() + 1*24*60*60) end) }),
  s("t2", { f(function () return snippet_date(os.time() + 2*24*60*60) end) }),
  s("t3", { f(function () return snippet_date(os.time() + 3*24*60*60) end) }),
  s("t4", { f(function () return snippet_date(os.time() + 4*24*60*60) end) }),
  s("t5", { f(function () return snippet_date(os.time() + 5*24*60*60) end) }),
  s("t6", { f(function () return snippet_date(os.time() + 6*24*60*60) end) }),
  s("t7", { f(function () return snippet_date(os.time() + 7*24*60*60) end) }),
  s("t15", { f(function () return snippet_date(os.time() + 15*24*60*60) end) }),
  s("t30", { f(function () return snippet_date(os.time() + 30*24*60*60) end) }),
  s("t60", { f(function () return snippet_date(os.time() + 60*24*60*60) end) }),
  s("task-add", {t("(task-add "), i(1), t(" t#"), f(function () return snippet_date(os.time()) end), t(" \""), i(2), t("\" :due t#"), i(3), t(")")})
}
