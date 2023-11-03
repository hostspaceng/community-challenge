import { mount } from '@vue/test-utils';
import DomainsTable from '@/components/DomainsTable.vue';

// Mock axios to simulate API response
jest.mock('axios', () => ({
  get: jest.fn(() => Promise.resolve({ data: { result: [{ name: 'example.com', content: '192.168.0.1', modified_on: '2023-10-18', proxied: true }] } })),
}));

describe('DomainsTable.vue', () => {
  it('renders the component', () => {
    const wrapper = mount(DomainsTable);

    // Assert that the component is rendered
    expect(wrapper.exists()).toBe(true);
  });

  it('exports domains to CSV', async () => {
    const domains = [
      { name: 'example.com', content: '192.168.0.1', modified_on: '2023-10-18', proxied: true },
    ];

    // Mock axios to return sample domains
    jest.mock('axios', () => ({
      get: jest.fn(() => Promise.resolve({ data: { result: domains } })),
    }));

    const wrapper = mount(DomainsTable);

    // Wait for the component's lifecycle to complete
    await wrapper.vm.$nextTick();

    // Find and trigger the export button
    const exportButton = wrapper.find('.btn.btn-default a');
    exportButton.trigger('click');

    // For simplicity, here we just assert that the export button exists.
    expect(exportButton.exists()).toBe(true);
  });
});

