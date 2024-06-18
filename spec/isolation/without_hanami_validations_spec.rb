# frozen_string_literal: true

require_relative "../support/isolation_spec_helper"

RSpec.describe "Without validations" do
  it "doesn't load Hanami::Validations" do
    expect(defined?(Hanami::Validations)).to be(nil)
  end

  it "doesn't load Hanami::Action::Validatable" do
    expect(defined?(Hanami::Action::Validatable)).to be(nil)
  end

  it "doesn't load Hanami::Action::Params" do
    expect(defined?(Hanami::Action::Params)).to be(nil)
  end

  it "doesn't have params DSL" do
    expect do
      WithoutHanamiValidations::Default.new.call({})
    end.to raise_error(
      NoMethodError,
      /To use `params`, please add 'hanami\/validations' gem to your Gemfile/
    )
  end

  it "has params that don't respond to .valid?" do
    action = WithoutHanamiValidations::NoParamsBlockValidCheck.new

    response = action.call({})

    expect(response.body).to eq(["[true, true]"])
  end

  it "has params that don't respond to .errors" do
    action = WithoutHanamiValidations::NoParamsBlockErrorsCheck.new

    response = action.call({})

    expect(response.body).to eq(["false"])
  end
end

RSpec::Support::Runner.run
