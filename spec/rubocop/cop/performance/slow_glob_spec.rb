# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Performance::SlowGlob, :config do
  let(:config) { RuboCop::Config.new }

  # TODO: Write test code
  #
  # For example
  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      Dir["components/**/app/tasks/*/**/maintenance"].map{|x|}
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `#good_method` instead of `#bad_method`.
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      Dir["components/{*,*/*}/app/tasks/*/{*,*/*}/maintenance"].map{|x|}
    RUBY
  end

  # TODO
  # it 'corrects `Dir[**]`' do
  #   expect_offense(<<~RUBY)
  #     Dir["components/**/app/tasks/*/**/maintenance"].map{|x|}
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `#good_method` instead of `#bad_method`.
  #   RUBY

  #   expect_correction(<<~RUBY)
  #     array.any?
  #   RUBY
  # end
end
