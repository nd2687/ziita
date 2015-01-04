bug_report1 = BugReport.create!(
  title: "記事投稿送信時エラー",
  body: '半角記号を使うとエラーが発生してしまいます。',
  created_at: Time.current
)
bug_report2 = BugReport.create!(
  title: "記事一覧ひょうじについて",
  body: '一般公開していないはずの記事が公開されてしまいます。',
  created_at: Time.current
)
bug_report3 = BugReport.create!(
  title: "記事一覧表示について",
  body: 'スクロールがうまくいきません。',
  created_at: Time.current,
  completable: true
)
