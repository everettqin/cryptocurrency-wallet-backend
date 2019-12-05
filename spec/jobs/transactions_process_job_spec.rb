
require 'rails_helper'

RSpec.describe TransactionsProcessJob, type: :job do
  subject(:job) { described_class.perform_later(123) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  # it 'is in urgent queue' do
  #   expect(MyJob.new.queue_name).to eq('urgent')
  # end
  #
  # it 'executes perform' do
  #   perform_enqueued_jobs { job }
  #   # expect xxxx
  # end
  #
  # it 'handles no results error' do
  #   allow(MyService).to receive(:call).and_raise(NoResultsError)
  #
  #   perform_enqueued_jobs do
  #     expect_any_instance_of(MyJob)
  #       .to receive(:retry_job).with(wait: 10.minutes, queue: :default)
  #
  #     job
  #   end
  # end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end